-- ============================================================
--  Indian History Storytelling App - MySQL Database Schema
-- ============================================================

CREATE DATABASE IF NOT EXISTS indian_history_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE indian_history_db;

-- -------------------------------------------------------
-- Users table (both regular users and admins)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    email         VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name     VARCHAR(100) NOT NULL,
    role          ENUM('USER', 'ADMIN') NOT NULL DEFAULT 'USER',
    profile_pic   VARCHAR(255) DEFAULT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login    TIMESTAMP NULL DEFAULT NULL,
    is_active     BOOLEAN DEFAULT TRUE
);

-- -------------------------------------------------------
-- Topics / Eras
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS topics (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    slug        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    icon        VARCHAR(50)  DEFAULT 'fa-landmark',
    color       VARCHAR(20)  DEFAULT '#C8860A',
    sort_order  INT DEFAULT 0,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -------------------------------------------------------
-- History Stories / Articles
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS stories (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    topic_id     INT NOT NULL,
    title        VARCHAR(255) NOT NULL,
    slug         VARCHAR(255) NOT NULL UNIQUE,
    summary      TEXT,
    content      LONGTEXT NOT NULL,
    image_url    VARCHAR(500) DEFAULT NULL,
    era          VARCHAR(100) DEFAULT NULL,
    author_id    INT NOT NULL,
    view_count   INT DEFAULT 0,
    is_published BOOLEAN DEFAULT FALSE,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (topic_id)  REFERENCES topics(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES users(id)  ON DELETE CASCADE
);

-- -------------------------------------------------------
-- Bookmarks
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS bookmarks (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT NOT NULL,
    story_id   INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_bookmark (user_id, story_id),
    FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE CASCADE,
    FOREIGN KEY (story_id) REFERENCES stories(id) ON DELETE CASCADE
);

-- -------------------------------------------------------
-- Comments
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS comments (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    story_id   INT NOT NULL,
    user_id    INT NOT NULL,
    content    TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (story_id) REFERENCES stories(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id)  REFERENCES users(id)   ON DELETE CASCADE
);

-- ============================================================
-- Seed Data
-- ============================================================

-- Default admin account  (password: Admin@123)
INSERT INTO users (username, email, password_hash, full_name, role)
VALUES ('admin', 'admin@indianhistory.com',
        '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lHry',
        'Administrator', 'ADMIN');

-- Topics
INSERT INTO topics (name, slug, description, icon, color, sort_order) VALUES
('Ancient India',      'ancient-india',      'Explore the roots of Indian civilisation from the Indus Valley to the Gupta Empire.',        'fa-om',          '#8B4513', 1),
('Medieval India',     'medieval-india',     'The age of Rajputs, Mughals, Vijayanagara and Sultanate empires.',                           'fa-chess-rook',  '#C8860A', 2),
('Mughal Empire',      'mughal-empire',      'Rise and fall of one of the greatest empires on the subcontinent.',                          'fa-crown',       '#9B59B6', 3),
('Colonial Era',       'colonial-era',       'British East India Company to the Raj — 200 years of colonial rule.',                        'fa-ship',        '#2C3E50', 4),
('Freedom Movement',   'freedom-movement',   'The struggle for independence — satyagraha, revolutionaries and mass movements.',            'fa-flag',        '#27AE60', 5),
('Maratha Empire',     'maratha-empire',     'Chhatrapati Shivaji and the rise of the Maratha confederacy.',                               'fa-horse',       '#E74C3C', 6),
('Indian Culture',     'indian-culture',     'Art, literature, music, dance, philosophy and religious traditions of India.',               'fa-music',       '#F39C12', 7),
('Modern India',       'modern-india',       'Post-independence nation-building, politics, science and society.',                          'fa-city',        '#16A085', 8);

-- Sample Stories
INSERT INTO stories (topic_id, title, slug, summary, content, era, author_id, is_published) VALUES
(1, 'The Indus Valley Civilisation',
 'indus-valley-civilisation',
 'One of the world''s earliest urban civilisations that flourished along the Indus river.',
 '<p>The <strong>Indus Valley Civilisation</strong> (c. 3300–1300 BCE), also known as the Harappan Civilisation, was one of the three early cradles of civilisation of the Old World. It flourished in the basins of the Indus River — one of the major rivers of Asia — and the now-dried Sarasvati River.</p>
<h3>Urban Planning</h3>
<p>Cities like Mohenjo-daro and Harappa displayed remarkable urban planning with grid-patterned streets, multi-storey brick houses, and an advanced drainage system that was far ahead of its time. The Great Bath at Mohenjo-daro is considered one of the earliest public water tanks in the ancient world.</p>
<h3>Trade and Economy</h3>
<p>Archaeological evidence suggests extensive trade networks reaching as far as Mesopotamia. Seals bearing an undeciphered script have been found across a vast geographic area, indicating a standardised system of trade.</p>
<h3>Decline</h3>
<p>Around 1900 BCE, the civilisation began to decline. Scholars debate the causes — ranging from climate change and shifting river courses to possible invasions — but the exact reason remains one of history''s great mysteries.</p>',
 '3300 BCE – 1300 BCE', 1, TRUE),

(2, 'Chhatrapati Shivaji Maharaj — The Mountain Warrior',
 'shivaji-maharaj',
 'The founder of the Maratha Empire and a legendary warrior-king who challenged Mughal supremacy.',
 '<p><strong>Chhatrapati Shivaji Bhonsale I</strong> (1630–1680 CE) was an Indian warrior king and a member of the Bhonsle Maratha clan. Shivaji carved out an enclave from the declining Adilshahi sultanate of Bijapur that formed the genesis of the Maratha Empire.</p>
<h3>Early Life</h3>
<p>Born at Shivneri Fort, Shivaji was deeply influenced by his mother Jijabai and the teachings of saint Tukaram. From a young age he gathered a band of Mavala soldiers and began capturing forts across the Sahyadri mountain range.</p>
<h3>Military Genius</h3>
<p>Shivaji pioneered <em>Ganimi Kava</em> (guerrilla warfare), using speed, surprise and knowledge of terrain to defeat far larger armies. He built a powerful navy — one of the first in Indian history — to protect the Konkan coastline.</p>
<h3>Coronation</h3>
<p>In 1674, Shivaji was coronated as Chhatrapati (sovereign) at Raigad Fort, establishing the Maratha Kingdom as a sovereign state. His administrative genius gave the kingdom a robust revenue system and a respected civil code.</p>',
 '1630 CE – 1680 CE', 1, TRUE),

(3, 'Akbar the Great — Architect of the Mughal Golden Age',
 'akbar-the-great',
 'Emperor Akbar''s reign marked the zenith of Mughal power, blending tolerance, art and administration.',
 '<p><strong>Akbar</strong> (1542–1605 CE), also known as Akbar the Great, was the third Mughal emperor who reigned from 1556 until his death. He expanded the empire to include almost the entire Indian subcontinent north of the Godavari river.</p>
<h3>Religious Policy</h3>
<p>Unlike many rulers of his era, Akbar pursued a policy of religious tolerance. He abolished the <em>jizya</em> (tax on non-Muslims), welcomed scholars of all faiths to his court, and founded the syncretic religion <em>Din-i-Ilahi</em>.</p>
<h3>The Navratnas</h3>
<p>Akbar''s court housed nine extraordinary gems — the Navratnas — including the poet Tansen, the minister Birbal, and the finance minister Raja Todar Mal, each a master in their respective field.</p>
<h3>Architecture</h3>
<p>He built the magnificent city of Fatehpur Sikri, blending Mughal and Rajput architectural styles. The Buland Darwaza, constructed to commemorate his victory over Gujarat, remains one of the tallest gateways in the world.</p>',
 '1556 CE – 1605 CE', 1, TRUE),

(4, 'The Sepoy Mutiny of 1857 — First War of Independence',
 'sepoy-mutiny-1857',
 'The watershed uprising against British rule that shook the foundations of the East India Company.',
 '<p>The <strong>Indian Rebellion of 1857</strong> — called the Sepoy Mutiny by the British and the First War of Independence by Indian nationalists — was a major uprising against the rule of the British East India Company.</p>
<h3>The Spark</h3>
<p>The immediate trigger was the introduction of the new Enfield rifle cartridges, which sepoys believed were greased with cow and pig fat — deeply offensive to both Hindu and Muslim soldiers. When soldiers in Meerut refused to use them and were imprisoned, their comrades rose in revolt on 10 May 1857.</p>
<h3>Key Figures</h3>
<p>The revolt saw heroes like <strong>Mangal Pandey</strong>, <strong>Rani Lakshmibai of Jhansi</strong>, <strong>Tantia Tope</strong>, and <strong>Bahadur Shah Zafar</strong> — the last Mughal emperor — leading resistance against British forces.</p>
<h3>Aftermath</h3>
<p>The rebellion was suppressed by mid-1858. As a consequence, the British Crown dissolved the East India Company and assumed direct control of India, beginning the period known as the British Raj.</p>',
 '1857 CE', 1, TRUE),

(5, 'Mahatma Gandhi and the Salt March',
 'gandhi-salt-march',
 'The 240-mile Dandi March that became a defining moment in India''s struggle for freedom.',
 '<p>The <strong>Salt March</strong> (12 March – 6 April 1930), also known as the Dandi March, was a nonviolent civil disobedience action led by <strong>Mahatma Gandhi</strong> to protest British salt laws in colonial India.</p>
<h3>The British Salt Tax</h3>
<p>The British colonial government held a monopoly on salt production and imposed a heavy tax on it. For the poor, who depended on salt for food preservation and daily nutrition, this was a crushing burden.</p>
<h3>The March</h3>
<p>On 12 March 1930, Gandhi set out from his Sabarmati Ashram near Ahmedabad with 78 followers. Over 24 days they walked 240 miles to the coastal village of Dandi, gathering tens of thousands along the way. On 6 April, Gandhi picked up a lump of natural salt — a direct act of defiance against British law.</p>
<h3>Impact</h3>
<p>The march triggered mass civil disobedience across India, drew worldwide media attention, and forced the British to negotiate. It is widely regarded as a turning point that accelerated the path to independence.</p>',
 '1930 CE', 1, TRUE);
